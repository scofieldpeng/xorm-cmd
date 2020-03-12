package models

{{$ilen := len .Imports}}
import (
{{if gt $ilen 0}}
	{{range .Imports}}"{{.}}"{{end}}
{{end}}
	"github.com/scofieldpeng/mysql-go/v3"
)

{{range .Tables}}
type {{Mapper .Name}} struct {
	mysql.TableFactory `xorm:"-" json:"-"`
{{$table := .}}
{{range .ColumnsSeq}}{{$col := $table.GetColumn .}}	{{Mapper $col.Name}}	{{Type $col}} {{Tag $table $col}}
{{end}}
}

func New{{Mapper .Name}}() *{{Mapper .Name}} {
    t := &{{Mapper .Name}}{}

	t.SetTableNode("default")
    t.SetMyself(t.self)

    return t
}

func (t *{{Mapper .Name}}) self() interface{} {
	return t
}

{{end}}

